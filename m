From: "Juanma Barranquero" <lekktu@gmail.com>
Subject: Re: question about COMMIT_EDITMSG crlf
Date: Wed, 14 Jan 2009 10:01:44 +0100
Message-ID: <f7ccd24b0901140101k1e0ca6aan1dbba537461a271a@mail.gmail.com>
References: <1976ea660901132117l7947157fw2922465a9b3945dc@mail.gmail.com>
	 <496D91CE.1000504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Frank Li" <lznuaa@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 10:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1ea-0006nv-KV
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 10:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616AbZANJBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 04:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbZANJBs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 04:01:48 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:39888 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbZANJBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 04:01:47 -0500
Received: by ewy10 with SMTP id 10so522329ewy.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 01:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XaQhnHtvm/NE75iS8HEdP40e59H2Nf8BhcJroi+KrKQ=;
        b=n1qrSWB16GDYcaS2gRq5J7TNAyZW5UyaM+hMOG+evbqzCMqa9yE2aHQ3Rdzl/ZguVn
         bfvyyXyE8qmb2947opJdqa2D7GLAiTayKWwfygOjFNjk2ezMvgbnc4DYGXihVOPMRp87
         HT4mMkisSOZhgL9E4V2HpuppOtNzfzugUiBf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O47w9gj0+1sRSwO1reeAV8Tw9iPA1gHtBUcfXlc3X2VuXIAprDhtze0yN0Th92GzMS
         cW2fOXc7Xw54qBWvqO8HeOkdhjfKmlaKsHOioniqqfFYRyOE73oDtU5CId7nhdt7Un3c
         mRVqy3/kJEHlFIkSk2dvTSVpd8hpAr556Y3jA=
Received: by 10.210.114.11 with SMTP id m11mr4739986ebc.147.1231923704896;
        Wed, 14 Jan 2009 01:01:44 -0800 (PST)
Received: by 10.210.141.18 with HTTP; Wed, 14 Jan 2009 01:01:44 -0800 (PST)
In-Reply-To: <496D91CE.1000504@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105607>

On Wed, Jan 14, 2009 at 08:18, Johannes Sixt <j.sixt@viscovery.net> wrote:

> No, there isn't. But perhaps you can use WordPad instead of Notepad? There
> are reports that this worked.

Or Notepad2:

http://www.flos-freeware.ch/notepad2.html

    Juanma
