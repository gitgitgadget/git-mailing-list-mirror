From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: git merge successfully however this is still issue from logical perspective
Date: Wed, 26 Oct 2011 20:08:11 +0800
Message-ID: <CAPgpnMSSOss=YxsMUZJ3E5TynDfHJG1i6PKitLBo_Tm7f=_+fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 14:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ2HL-0006wb-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816Ab1JZMIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 08:08:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37394 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751Ab1JZMIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 08:08:12 -0400
Received: by vws1 with SMTP id 1so1341125vws.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Hueilz8IWMQ1qxDtG1knENpMOin0ZWK2AKS2Ie7KCdI=;
        b=rL0CjrCBxZLYyg00WBbM3di9m4GwbOSHFQ/DX7AinP/GnnPtIzNorbvFY7/ASsniu0
         ZfcEZtKwoIU37IHgvltEx8wXU7mdPhBwQ0dcsolvluyXI8RU9+8v2xRE/RQUyN754/M2
         2D6EeyxnskyqtCsM1711OX3GKTubVc/doiXqw=
Received: by 10.52.17.239 with SMTP id r15mr32236639vdd.48.1319630891598; Wed,
 26 Oct 2011 05:08:11 -0700 (PDT)
Received: by 10.52.167.201 with HTTP; Wed, 26 Oct 2011 05:08:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184256>

Hi all,
   Do this case can happen? When I do merge from one branch to master
branch,merge successfully however from code logical perspective it
fails and It cause code compile (our project is using C++ language)


Thanks
Lynn
