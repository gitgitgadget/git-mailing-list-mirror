From: "Michael J Gruber" <git@drmicha.warpmail.net>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Sun, 04 Apr 2010 15:11:34 +0200
Message-ID: <1270386694.2526.1368218745@webmail.messagingengine.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
 <87hbpwpoko.fsf@yoom.home.cworth.org>
 <5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
 <201002081614.24284.sojkam1@fel.cvut.cz>
 <871vgr78lr.fsf@yoom.home.cworth.org>
 <87iqa2y0gz.fsf@steelpick.localdomain>
 <87r5oqe7mi.fsf@yoom.home.cworth.org>
 <871vgmki4f.fsf@steelpick.localdomain>
 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
 <87tytdiqob.fsf@steelpick.localdomain>
 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
 <873a0xhwxs.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
 <87eikfhec1.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002202321430.20986@pacific.mpi-cbg.de>
 <87pr2i8g8o.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michal Sojka" <sojkam1@fel.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 15:11:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyPcD-0003jx-1L
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 15:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab0DDNLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 09:11:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56504 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754139Ab0DDNLe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 09:11:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67F4EEA1E0;
	Sun,  4 Apr 2010 09:11:34 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Sun, 04 Apr 2010 09:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=g2zTdPN+7CEMalhz0ihRmrr5Ce4=; b=NWoPiv097YjMK7VR1XLribE6GRff68ngfra7TP/cbSPbTCQ1lc32m4l+CorOqmeddqtyR+GCWWHDiy6G7Fk0DlMM0JX0QVu5+CPhL1eVTOvVuhGUoP/1P23+QBf6qMYQoGAukcfX0JPdKlhMOpNkUrKzPix6nvIY7FugZ7mTVyM=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 496C4189C5F; Sun,  4 Apr 2010 09:11:34 -0400 (EDT)
X-Sasl-Enc: QtBhkgN9uRuQPad0im1BhYlC77/KX7/i6tPzuhX/27vV 1270386694
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <87pr2i8g8o.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143922>



On Fri, 02 Apr 2010 09:29 +0200, "Michal Sojka" <sojkam1@fel.cvut.cz>
wrote:
> To all contributors to test-lib.sh mentioned in Bcc:
> 
> You're getting this message because you're recorded as contributing one
> or more changes to the test-lib.sh file in the Git project, and are
> therefore one of many copyright holders in the file.
> 
> We would like to extend the license of that file from GPLv2 only
> license to GPLv2+ by adding the recommended "or any later version"
> clause to the license. This will give us license compatibility with
> GPLv3 projects, which would like to reuse test-lib.sh.
> 
> Please respond to this email with one of the following:
> 
>  YES, I agree to relicense all my contributions to test-lib.sh to GPLv2+
>  with the addition of the "or any later version" clause.
> 
>  NO, I would rather not, please send me more email to convince me.
> 
> I'm putting your address to Bcc as most people are probably not
> interested in receiving responses from dozens of other people. I will
> track the status of received responses at
> https://git.wiki.kernel.org/index.php/Test-lib_reclicensing. Please do
> not remove git@vger.kernel.org when responding so that your response is
> available to everyone.

What else do I need to do besides my acked-by to Junio's patch in
<4B8E1EBA.4090406@drmicha.warpmail.net> on 3/3?

For whatever's sake:
>  YES, I agree to relicense all my contributions to test-lib.sh to GPLv2+
>  with the addition of the "or any later version" clause.

Michael
