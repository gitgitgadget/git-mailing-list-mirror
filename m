From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to installed bindir
Date: Mon, 30 Nov 2009 16:07:52 +0900
Message-ID: <20091130160752.6117@nanako3.lavabit.com>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net> <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net> <7vtywefn88.fsf@alter.siamese.dyndns.org> <20091129025251.GA1771@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0Mz-0004ft-2n
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbZK3HIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZK3HIN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:08:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39559 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbZK3HIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:08:13 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id F3D5511B7BB;
	Mon, 30 Nov 2009 01:08:19 -0600 (CST)
Received: from 1088.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id F5KRSJI5PENW; Mon, 30 Nov 2009 01:08:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hcAi/Znijj9xKVI2eoAvEKyOmOhc9UAnNIMdFyycHKzrEO5z8caUnbYpIumDlxCV+/xDcEECccoK7AZ9Ftao8SX211uBNhleCdjR2/JGM8OQD52HQaihIHBA9v8uRgfR1SRU5TZe9ThJNso16m7F6rt/QQL6ep8DsfIAsuSInn0=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091129025251.GA1771@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134061>

Quoting Matthew Ogilvie <mmogilvi_git@miniinfo.net>

>   4. Rename test-bin.  Perhaps "bin-wrappers", "bin-dashless",
>      "bin-install", "bin", or "bindir".  Any preferences?

"gitrun" or "rungit"?

I prefer the latter because too many files begin with "git" after compiling.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
