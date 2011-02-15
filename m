From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Regarding GIT API
Date: Tue, 15 Feb 2011 20:09:40 +0300
Message-ID: <AANLkTimtiXN5EpejfCSVERCHhc1F7bKQiRNuf7GxbvaR@mail.gmail.com>
References: <loom.20110215T120434-373@post.gmane.org>
	<AANLkTim4ucYtoyNEM2+=-dJTmpBtqy1zJOEX3k3Wk+XU@mail.gmail.com>
	<4D5A744F.5000208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Abhinav Goyal <honeykool23@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 18:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpOPL-0000mP-Vb
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 18:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab1BORJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 12:09:44 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36102 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1BORJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 12:09:42 -0500
Received: by qyj19 with SMTP id 19so2536125qyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mgG2MURXQI/JWsZD+lXZX2JX0ZAd9YeJpP/VbHx3hsI=;
        b=IxkQex8SaoBeBef3EkzFjR2xtNbNnwREuk5thTb0Wso6qRcz9Vu2nFXTwHOnfFGWdl
         xrLg2PqkOtbtDD+a6JQq3p5K4X6ZFRq/sGEypPxKv3aL8/7QxIrR0MzwWu/ACjFcNqHA
         /UL+B28S+Dxh+uRVJy8VC5L4+iGordsrK2njM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H+BC+dOBxxRZIx4M8WNhp+AjFItoY1xh/45bPUjK7JonpxSRBd7yY7QOPe+gl/7yaJ
         dcpohxEWCZnPH72WD9w+n82pmlyGruxlMhNCZjgB7ykrQ3q1QViYzt7/mk9WcjnfMs9Y
         qNIwHUyLzY/+1p/h/5CJNX6UA8wwHFFIqyydQ=
Received: by 10.229.220.133 with SMTP id hy5mr4116699qcb.269.1297789780739;
 Tue, 15 Feb 2011 09:09:40 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Tue, 15 Feb 2011 09:09:40 -0800 (PST)
In-Reply-To: <4D5A744F.5000208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166858>

On Tue, Feb 15, 2011 at 3:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> You mean "plumbing" for the commands with robust interface.
>
> The front-end commands are "porcelain": they may break when used for
> heavy (scripting) work...

Thank you for correction...


Dmitry
