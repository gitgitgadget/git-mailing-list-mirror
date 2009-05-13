From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 01:26:26 -0400
Message-ID: <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
	 <4A09594F.4040603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 13 07:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M46zD-0001Dm-PI
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 07:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZEMF00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 01:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZEMF00
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 01:26:26 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:51240 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZEMF0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 01:26:25 -0400
Received: by gxk10 with SMTP id 10so811558gxk.13
        for <git@vger.kernel.org>; Tue, 12 May 2009 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=26SrwNfONrOru7GbRaj1UA6J6rdXR1iVsE/A32EDfvs=;
        b=oQzWzA3aJ9GpEJ2pQzkc2tvt/FOcXTNs8GrDBzNalhqDam3UfJl5dCiKfekcthVl/9
         dRkU/BXxZJd2PxtCBAqkEWH9ulGxVv2ZCY69qy23LCFn2InY7Y9QawTI6uOSi/KpduGu
         9VIqtDoI7vMD2ZknECLcpgObZvl/hTPRzhZdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l/MXntZV7u+I/khRH4khA7yevHXt36PxSDMxNt0KESN3zIvnnMHP/OJ3qZvtnnsvvY
         jhIQuwcwDb5F38QOEAuue7DD+EKzDX21uZ0kNN63ZqULXi9l+ySRKcWIMo+sJNUKHWYX
         KmyJkUVJuEoPo4vFja9tb4dWNz5HKqRO8CVu8=
Received: by 10.100.110.9 with SMTP id i9mr180130anc.130.1242192386445; Tue, 
	12 May 2009 22:26:26 -0700 (PDT)
In-Reply-To: <4A09594F.4040603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118981>

On Tue, May 12, 2009 at 7:11 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Seriously, we had that discussion when the feature (change of default
> behaviour) and warning were introduced, so it's too late for a change.
> But it's never too late to do
>

It's open source. it's too  late to change 1.6.3 but the error message
could be easily remove in 1.6.3.1

I'll reiterate that I shouldn't have to explicitly set default
behavior to not see error messages.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
