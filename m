From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space and space-before-tab
Date: Thu, 24 Jul 2008 17:29:12 +0900
Message-ID: <20080724172912.6117@nanako3.lavabit.com>
References: <4888144E.8090300@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwDz-00044B-Tg
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYGXI3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYGXI3o
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:29:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36915 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbYGXI3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:29:43 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D6CE2C8889;
	Thu, 24 Jul 2008 03:29:33 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 67RX9NLSKK6X; Thu, 24 Jul 2008 03:29:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Bw2DhxKtjW+K5TMpYyOE4xTI6hx791nCK3Ghnkbg3l+KUBZux4trMg788iOjdniT9ZfwVWWcrubnBHqs3Dmv2dFiqzKiZ6p/DxbyTDSy7lFqxgNNKkzhl9Ok0ozCE8g8/rzKXbuGQUHXUW2N3ihSbhCf0CYdNn62mquouAqyEFg=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting "Peter Valdemar Mrch (Lists)"  <4ux6as402@sneakemail.com>;
In-Reply-To: <4888144E.8090300@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89850>

Quoting "Peter Valdemar Mrch (Lists)"  <4ux6as402@sneakemail.com>:

> The '-trailing-space' syntax to disable the trailing-space setting is
> not obvious and not documented as far as I can see. I would have
> assumed a value of '' would disable it.
>
> Is there a documentation bug here? If so, I suggest this patch. I
> didn't find anywhere else where the '-setting' syntax was used to
> disable something.

Doesn't gitattributes(5) describe the overall syntax in detail?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
