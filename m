From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] gitk: Honor TMPDIR when viewing diffs externally
Date: Wed, 30 Dec 2009 12:13:14 +0900
Message-ID: <20091230121314.6117@nanako3.lavabit.com>
References: <1258680422-42179-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Aguilar <davvid@gmail.com>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org, paulus@samba.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 04:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPp0G-0004wy-62
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 04:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZL3DNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 22:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZL3DNT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 22:13:19 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39609 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbZL3DNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 22:13:18 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 9A40411B89C;
	Tue, 29 Dec 2009 21:13:18 -0600 (CST)
Received: from 9683.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id SIA94XC8YSWJ; Tue, 29 Dec 2009 21:13:18 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=uxpu/fhhtjCwcbgu6Mdz7p33yCILwxd/ULBJZPpWglJHAwUT/LRqk5zNC/0Xu9n0wFlmOzqYAkjjBMkpANShBstKUsdAlGPSn1CyvS8h3mOMtBCKWqM3qfvsiPfxnvSEK2K1dGXO+MA4CHrEAFa94E164Vc+w/ckdCxO0VBMqhc=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <1258680422-42179-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135852>

Junio, could you tell us what happened to this thread?

A patch to help running diff command from gitk in a read-only place.
