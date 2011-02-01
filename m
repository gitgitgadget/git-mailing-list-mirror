From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: [1.8.0] Remote tag namespace
Date: Tue, 1 Feb 2011 09:10:20 -0500
Message-ID: <AANLkTimzvrJsGpc5T6D43RFQvqEu0WfSidbSw5ukahCy@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkGwL-0005GV-6a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1BAOKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 09:10:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54821 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1BAOKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 09:10:21 -0500
Received: by eye27 with SMTP id 27so3107023eye.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=veL1ZDJ8hfl9s5KT6/dCreUw8MFq97EoZvx+8fggo/Y=;
        b=c4uzi3pVsmUxHQJNFZfVn20XxCIK633pyXWNbhQjwovQKeKZYGZv7vCrKfADLvej+y
         cO19kdbWlJaIimwXz47lX9qwuv7beRJuy9JJvbFugsKmA2jj4ISaNsjV6RlJHA8dmRFr
         Qg/as/pT6+epqRNVmCowNl+DxcmJA2vqmNgDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=aDzkqq8xn4KrseXTG1DASb+ONmT4faQkdccaMU9f1H54eW3QnOokRpBSt0kJnnAF1a
         g/WjK3aCm/24vX1YowiX2YnfMMsfm9zjYBljWCPncE4tNRqZDuFv0JNDTiJ45IN7rQHl
         ++22nXHRLxZQVoi0MdpzF5jPSaotW5meWpFLg=
Received: by 10.14.127.137 with SMTP id d9mr1424438eei.2.1296569420090; Tue,
 01 Feb 2011 06:10:20 -0800 (PST)
Received: by 10.14.51.209 with HTTP; Tue, 1 Feb 2011 06:10:20 -0800 (PST)
In-Reply-To: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165805>

On Tue, Feb 1, 2011 at 05:44, Nguyen Thai Ngoc Duy <pclouds@gmail.com> =
wrote:
> On Tue, Feb 1, 2011 at 11:16 AM, Nicolas Pitre <nico@fluxnic.net> wro=
te:
>> On Tue, 1 Feb 2011, Nguyen Thai Ngoc Duy wrote:
>>> Another random wish, which does not come with a proposal. How about
>>> tag namespace (ie. tags from a remote stay in remote namespace)?
>>
>> Please make this into a proper proposal. =A0this would be indeed a h=
uge
>> improvement.
>
> OK I'm not familiar with tag code, but I can try.
>
> Proposal:
>

Remote tag namespace is a great feature long overdue in git. Due to
git's current flat tag namespace I am forced to make my tags
artificially long like
"my_project_repo_name/v-1.2.3".

Looking forward to remote tag namespace -- sooner the better!

--Leo--
