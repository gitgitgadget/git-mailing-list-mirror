From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: commit type
Date: Fri, 31 Oct 2008 11:04:22 -0700
Message-ID: <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>
References: <loom.20081031T174821-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 7rans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:06:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvyNU-0005Xn-27
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYJaSEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYJaSEb
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:04:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:38060 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYJaSEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:04:30 -0400
Received: by ey-out-2122.google.com with SMTP id 6so507403eyi.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qyRpXSzig7fuALtrcLK+vUP6mcPZplgu5+b4UjZaKT4=;
        b=efQkttpEBE/JM8ryWnFwkcHwRSea9WQ2mFg1W2cxX5ZJznS0Fay26Wd8lEN5TS6nGl
         E/pwE1IhHSPL8wQ6tStTmUvFbtr7FVjo5VK10FCQyfxiwDiPA+gsJcN9zsCIHIVte/zT
         pkXme0hievVfUjVxgDqdXE4HiZVcMsVb1/Zy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nB3J8dCIkH5oZoac8zECqTmLKmLF5eGBFb04IeZr+VRST3yeswGaSwzQaFPecDZdvl
         Y96gJyJ11zkzYB1QnSSKbSVIi/5m4WAR9FCymCRDw2/P5bcLGJ3Aspx+f0VIc6jHhBm0
         gmlMWo6yX+pxphaqvV2rE7YHecgV3TwTTr+YQ=
Received: by 10.210.126.18 with SMTP id y18mr13686204ebc.131.1225476262732;
        Fri, 31 Oct 2008 11:04:22 -0700 (PDT)
Received: by 10.210.51.7 with HTTP; Fri, 31 Oct 2008 11:04:22 -0700 (PDT)
In-Reply-To: <loom.20081031T174821-603@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99615>

On Fri, Oct 31, 2008 at 10:58 AM, 7rans <transfire@gmail.com> wrote:

> Currently I achieve this by adding "[type]" to the end of my commit messages.
> But of course that's less than optimal.

Why is that less than optimal? It seems a lot less intrusive than what
you suggest.


Dave.
