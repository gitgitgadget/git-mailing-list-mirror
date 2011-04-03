From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Feature request: Daily RSS update digests
Date: Sun, 3 Apr 2011 18:19:56 +0200
Message-ID: <AANLkTi=SzMTNU-bf9-0OnLPqcs29kWL6oJ7uf8Zb4kP6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 18:20:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Q2K-0003Qe-Pt
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab1DCQUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 12:20:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54811 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab1DCQUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:20:16 -0400
Received: by iyb14 with SMTP id 14so5176771iyb.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=6NmmZPplMDJOLPNPcxSAtIUVVUK4+X7Nai41BRu7vu4=;
        b=FZvu0Zz0XeJuryROql/HQq3quon1/Y3Bt1nX7//5eYCB/Eh4cTNp+2TVHMP2aXB2ro
         3rJ9ecBqwixCKCyH93PNe3l74adIaIEDRyi54CnW+pK+xUb5Q9ICN9gAKZS1WyGBqUrl
         V9QFyCbFx/rpTC38ZmxE/3a4QFcGSxVfnnAxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=fiNddUDVTlqyPFWdL09jlMCu1OpOjxUpW+2qcPMHiRV7thJZ7hS3lTWdHAmLNmUDH6
         njFvrQhmEECRSw+6spCzcDTicC3kCnw/uxARW6tGQak1kC4tmRivwuYWHy+UmawkMoOY
         8DBjHMSRwGkcC2UpLzEjkfj+LAmzygzS2nVY0=
Received: by 10.231.210.148 with SMTP id gk20mr6266577ibb.110.1301847616059;
 Sun, 03 Apr 2011 09:20:16 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Sun, 3 Apr 2011 09:19:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170701>

Hi all,

following a certain repo via RSS can be quite useful in some cases,
but a few dozen commits at a time can ruin that quite easily.

I would prefer to follow a digested RSS feed which updates once daily, tops.



Richard

PS: This seemed to be the best place to put this request. If not, feel
free to cuss at me and tell me where else to take this :)
