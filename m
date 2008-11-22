From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [Announce] teamgit-0.0.8 receipies preperations
Date: Sat, 22 Nov 2008 15:57:45 +0100
Message-ID: <bd6139dc0811220657y39970764x3ad9f5b66689cbbb@mail.gmail.com>
References: <2fcfa6df0811220602p103a51e8l6fdf2401b270240f@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Abhijit Bhopatkar" <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Sat Nov 22 16:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3u1l-0008BY-Ug
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 16:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203AbYKVO5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 09:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758202AbYKVO5r
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 09:57:47 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:13247 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758201AbYKVO5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 09:57:46 -0500
Received: by yx-out-2324.google.com with SMTP id 8so598963yxm.1
        for <git@vger.kernel.org>; Sat, 22 Nov 2008 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dNbBtv+D+NaQD3LLzSNaA7YtwAHdBFYjt9uAmbJpDYc=;
        b=SdwQdpbWM/Y447sllcX1OoMI8w+Hsq5M/m7UKeoTv3ljqhUkCVk4xEfCLP5a1n/+bY
         cmvE7qGOYcI5ESMQ8TP6CEDqHHosyeUZccZm8nhmpfD4G/WLdakFKAiF9hznWVVLP21r
         G+c/I2uxRBSik7WezccoaC73Oa9co3cThQuf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=vt6O0CXt+wp9oyPfcdlK0kbG8z1+wVkRaUWBevmq4acN2pWEQzvbz1jMqfcD7HSrnA
         pRzQc9++6cMux5TjYE76QS4coVcmzsxW9JespzS1d+aGacFb45sibuYZMlaaVc2fp1NP
         +yGX6RNqSzUy+JHI6XUM1Xpvzx75Nmvvt9rBk=
Received: by 10.150.202.9 with SMTP id z9mr3204149ybf.8.1227365865367;
        Sat, 22 Nov 2008 06:57:45 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Sat, 22 Nov 2008 06:57:45 -0800 (PST)
In-Reply-To: <2fcfa6df0811220602p103a51e8l6fdf2401b270240f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101553>

On Sat, Nov 22, 2008 at 15:02, Abhijit Bhopatkar <bain@devslashzero.com> wrote:
> This menu is constructed on the fly parsing output of 'git help --all'
> Then when you click on a menu item it issues git help <command> ,
> parses the manpage and presents its options in a guified form.
> It even display nice tooltips describing the option.

Whoah, looking at the screenshot, that's pretty awesome! Maybe I
should start keeping an eye on this project ;).

-- 
Cheers,

Sverre Rabbelier
