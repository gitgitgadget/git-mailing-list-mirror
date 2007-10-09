From: "Alan Hadsell" <ahadsell@gmail.com>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 09:03:40 -0400
Message-ID: <2b3a6fcd0710090603l3c3578caq3bfa6a1b8ec583f@mail.gmail.com>
References: <11918785613855-git-send-email-prohaska@zib.de>
	 <11918785611059-git-send-email-prohaska@zib.de>
	 <20071008214451.GB31713@thunk.org>
	 <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de>
	 <Pine.LNX.4.64.0710091335580.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEkk-0006Ju-Qt
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbXJINDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755069AbXJINDo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:03:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:25233 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbXJINDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:03:41 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1651768wxd
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MrAZq468acg6ycQ7y5JgHxOSlhF4NMS1uXYJOgCkMSo=;
        b=qbQHAAPofGCXjNJA9L9t5ZIkgE8L5BH06fyV3TfSTMhNhvINuocSpvY69ry9T1o0fjR/rZioFZn4i0idMt3AMWGFYRz7+5ZqyhdPNIWr6YW/GX+9THe5VOdQnjaAKJLl7SXJJomdrHE/PdOwluGYBCQ8VdoJZNcrX1wXgFBD144=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+woHyodJnuQBA2TiUxIADzNW3LAdCD4e3u1EC5J7GfvPlnzZLpwtlQXIcShu7uF33v0uduycllnRwzrq2kTbwpIgmjuWII2n4o8NRPXaDK6yiEAvDQuB7QsD0WU2Rc2x7ZXFIPfUKKjAAErMKuSPUV20b1KX2AZynL2AcYZGu4=
Received: by 10.90.71.3 with SMTP id t3mr5535572aga.1191935020289;
        Tue, 09 Oct 2007 06:03:40 -0700 (PDT)
Received: by 10.90.101.15 with HTTP; Tue, 9 Oct 2007 06:03:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710091335580.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60402>

On 10/9/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> What does TortoiseCVS use?

They don't actually include it in the package, but they recommend
WinMerge http://winmerge.org/, which is free (GPL).

-- 
Alan Hadsell
