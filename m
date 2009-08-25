From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-tag(1): Refer to git-check-ref-format(1) for <name>
Date: Tue, 25 Aug 2009 17:21:00 +0900
Message-ID: <20090825172100.6117@nanako3.lavabit.com>
References: <87ab2gsqst.fsf@jondo.cante.net>
	<7veirs6qxn.fsf@alter.siamese.dyndns.org>
	<20090822094518.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 10:21:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfrHG-0008M0-9n
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 10:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbZHYIVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 04:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZHYIVC
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 04:21:02 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58776 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbZHYIVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 04:21:01 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D454A11B820;
	Tue, 25 Aug 2009 03:21:02 -0500 (CDT)
Received: from 5040.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id RHALV56ODKJN; Tue, 25 Aug 2009 03:21:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=3fLYi9x1lQZVK4YeXdddwkWlI6K6VirggP1/DyBT5hoqzgeJyMo46xFzzOoqRza/rzmtxzFdXHA32FKyPvG6tGhJ3uJiU0cQA2e6ip/EADn1b1qVkJs3e0meVIDIb+DbkG/HASz1sWsNepOkDCtrYshLf32WW5zX2hS6BqIpkZo=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090822094518.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127015>

Quoting myself...

> Subject: Documentation: consistently refer to check-ref-format
>
> Change the <name> placeholder to <tagname> in the SYNOPSIS section of
> git-tag documentation, and describe it in the OPTIONS section in a way
> similar to how documentation for git-branch does.
>
> Add SEE ALSO section to list the other documentation pages these two pages
> refer to.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>

Should I further polish this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
