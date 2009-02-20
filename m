From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Add "compare with index" action.
Date: Fri, 20 Feb 2009 09:12:34 +0100
Message-ID: <551f769b0902200012vdf1bdb0qefa88e43cb16205b@mail.gmail.com>
References: <499D80A2.7030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQWM-0000C0-FQ
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbZBTIMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZBTIMi
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:12:38 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48910 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZBTIMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:12:37 -0500
Received: by bwz5 with SMTP id 5so2177730bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N92fPgt33TPxiKOmX5WkXvDT9Va2rt+mseaC/yKZX4U=;
        b=dUIIKzVvWGsynNzJS0bQo2pJl04iq/slrBZK25JjomXJ41pNFJ5OMjSRX/9UQI1jgP
         zTQH/g6GeqPKwzn6NN+EiGDkljXSb9Rk/JT94/YodMo8txwvG4DAXt5EqcyTca7Rgpap
         6MK5tFSiTZ+Jgw8nh5q89wWQlhpjwkArQVFJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ELA2gULacLd5qQV3/Vp6j14rTip3J2Ep1x8Nt5bFBSxkiEPi9oI5W7g6IqEStBUMZN
         1gpZWcbGDTclYmUfCQ0zjV2yMKbZI8FwJpOdU8D3liXAESxE6+7u3Y03PXQPn0n5zugp
         U0h2BYgi6Fr2FBl7yYloTcHEvhdGIAcEhl3vI=
Received: by 10.181.197.6 with SMTP id z6mr188877bkp.119.1235117554166; Fri, 
	20 Feb 2009 00:12:34 -0800 (PST)
In-Reply-To: <499D80A2.7030205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110812>

2009/2/19 Yann Simon <yann.simon.fr@gmail.com>:
> In the Compare With... menu, the "compare with index" action opens
> a diff editor that compares the workspace version of a file and its
> index version.
>
> The local file can be modified and saved.
>
> The staged version can be modified and saved. This updates the index.
> For this, add methods into GitIndex to allow to specify a content
> different from the file.
>
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
> This patch is working bug I am sure it could be better.
> I am sending it for review, so any comments are welcome!

This patch is whitespace corrupted.
Please ignore.

-- yann
