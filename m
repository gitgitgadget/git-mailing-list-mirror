From: demerphq <demerphq@gmail.com>
Subject: Re: [GSoC14][RFC] Is there any interest in adding a port of
 checkpatch.pl to contrib/?
Date: Wed, 19 Mar 2014 09:40:24 +0100
Message-ID: <CANgJU+UEqJ-x9-T0tXPpgPq1-Sw888CppODrszqOXqLDOmr-Kw@mail.gmail.com>
References: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 09:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQC36-0008Hb-RF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 09:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbaCSIk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 04:40:27 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:58637 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbaCSIkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 04:40:25 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so8281839qae.31
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iegHIsit7JuuKQ6JQQxhotG1SROxJ5zY5THSEwUkQpk=;
        b=znLcvIE70PMxBaUkBYxdbYrLNkCpGOdij1gdwgSvpHziE0TTrO46bOtixna10/pTH9
         3KsKnsOADPjSssTg/uyRszXWkyo/F56O50/znIn+sLWTeTT6wXo++enT8HSZps32YBmA
         ooPcK0pigUzpAzLF9Il8f7LbpXQsu7mk4V6yH4KOt6svnI9qCYbho9b+IxAwBarztBUf
         5bhZOuf1sDbVr6sqfHdKuwsfHv9RTjwXHua9uwYJlmAlI772ljAoaYaRQ8OVmBwMz4bf
         I73/fe3XD9rTDGPUMrpx+zMnJhJ07T8rTKQT6/PFIAm7FlNgFzfIG7/iM2pDP27yhi7j
         faCA==
X-Received: by 10.229.66.202 with SMTP id o10mr41498069qci.7.1395218424294;
 Wed, 19 Mar 2014 01:40:24 -0700 (PDT)
Received: by 10.140.104.200 with HTTP; Wed, 19 Mar 2014 01:40:24 -0700 (PDT)
In-Reply-To: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244421>

On 18 March 2014 02:38, Jacopo Notarstefano
<jacopo.notarstefano@gmail.com> wrote:
> 3. As far as I can tell, checkpatch needs to be run from the root
> folder of a linux repository clone. Cloning several hundred MBs for a
> single perl script looks a little foolish to me.

If that is your worry maybe you should upload the script to CPAN.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
