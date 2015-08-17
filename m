From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Mon, 17 Aug 2015 09:45:58 +0300
Message-ID: <85421439793958@web4j.yandex.ru>
References: <349031438778845@web22j.yandex.ru> <CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZREBN-0005eR-GL
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 08:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbbHQGqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 02:46:03 -0400
Received: from forward11j.cmail.yandex.net ([5.255.227.175]:41474 "EHLO
	forward11j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774AbbHQGqC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2015 02:46:02 -0400
Received: from web4j.yandex.ru (web4j.yandex.ru [IPv6:2a02:6b8:0:1619::304])
	by forward11j.cmail.yandex.net (Yandex) with ESMTP id B621B21C67;
	Mon, 17 Aug 2015 09:45:59 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web4j.yandex.ru (Yandex) with ESMTP id F3A803009B5;
	Mon, 17 Aug 2015 09:45:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1439793959; bh=JDDfro36IjiTYwIWaLG3AV2/O+7Vo94XV2+tZC26bGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=uA6xyQ7d/NKvKZ0Xvetlh8/780t99cQofu9PJQDgMPLMyixUMjkl6/spQ6PG2rAAc
	 ph7E6hsMtp4EheNgpOiTh31djNcuBYHRLWXZfkAmjSE7hdHZRGgzp2IeWmgiHUwk26
	 c6J2ZkUgLGIHtrJSN8A7otBvcfYHV/+6FGBjSMiM=
Received: by web4j.yandex.ru with HTTP;
	Mon, 17 Aug 2015 09:45:58 +0300
In-Reply-To: <CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276034>



15.08.2015, 12:19, "Duy Nguyen" <pclouds@gmail.com>:
>
> Probably because nobody is interested and steps up to do it. The lack
> of response to you mail is a sign. Maybe you can try make a patch? I
> imagine it would not be so different from current --contains code, but
> this time we need to look into commits, not just commit id.
>

Yeah thanks much, I'll try. Actually that was my original intention, I just wanted to have some "reasonability check" for my idea.

-- 
  Ivan
