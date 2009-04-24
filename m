From: Michael Witten <mfwitten@gmail.com>
Subject: Re: "SHA1" or "SHA-1"
Date: Fri, 24 Apr 2009 08:53:04 -0500
Message-ID: <b4087cc50904240653n2e297231u21ab728e1de134cd@mail.gmail.com>
References: <49F1D1C6.9238.64B16D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 15:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxLrb-0004zF-FK
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 15:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbZDXNxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 09:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbZDXNxL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 09:53:11 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:52423 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571AbZDXNxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 09:53:10 -0400
Received: by qyk16 with SMTP id 16so2215806qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WcAFxyZ+rHgQLvCIDKW4lwKQihTG61WCJbFQIjcwUTE=;
        b=ECr3EdQIkCaUpP5Fjb95wIJkuzO7Zyec1NXvLw3SY7nl4CEquxSHiaQsyarB/MAqYf
         HrY1fXw1ngJG6ZGme2NqMqVmQSBzw8HThY7w7fZQLqlO4yIqPTbVt0d7L6TBsjw2+R8f
         wTyBitC3joBQdPeh9ch6t505FZnA/gft1GseU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jSL2TfQx4U4pgWH28pgDcrZZ4BcGnrgGM2FG5qERpEQi8h87y7Xc3qwitsnhnagKMe
         7GCDgLhzy8+h4n7+Kv7W+IXc+acoXqIqfCf1EQIHA58cWLfZPV0Sj2sgUFxDjyJf5ULr
         RAGWtBvLI82Y/rOpi7D2NX6AiWVIQODaHr6rE=
Received: by 10.224.32.146 with SMTP id c18mr2769454qad.58.1240581184244; Fri, 
	24 Apr 2009 06:53:04 -0700 (PDT)
In-Reply-To: <49F1D1C6.9238.64B16D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117436>

On Fri, Apr 24, 2009 at 07:50, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:
> I always thought, the official notation for "Secure Hash Algorithm #1" [FIPS-180-
> 1] was "SHA-1", and not "SHA1". However in the documentation I found many
> occurrencies of "SHA1". If someone is working on spelling errors, could that be
> changed?

I too believe it is SHA-1; I endorse changing all occurences of SHA1 to SHA-1.

> Unfortunately RFC 3174 talks about "SHA-1" all the time, with the exception of the
> title that says: "US Secure Hash Algorithm 1 (SHA1)"...

Sigh... Such is the world of "standards".
