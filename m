From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] t9700-perl-git.sh: Fix a test failure on Cygwin
Date: Wed, 30 Dec 2009 22:40:23 +0900
Message-ID: <20091230224023.6117@nanako3.lavabit.com>
References: <4B059150.5050303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPynl-0005E7-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 14:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbZL3NlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 08:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbZL3NlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 08:41:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52779 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbZL3NlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 08:41:08 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 10E3411B85A;
	Wed, 30 Dec 2009 07:41:07 -0600 (CST)
Received: from 9478.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 1F7BOAXOKBLQ; Wed, 30 Dec 2009 07:41:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=lKIpaKkZlaqIhBcVj3kHIPKXyXYtei7UfeErSadpiXO7wuwubrIYLmvEcb3pBUOi2X4bWniXGZFu3p7xsGxuUknXJhfBW5M+pEjgQnXkvSvvvGhfaHgNg68OWgELWlBiYNAcPRF/8cHxwZ4+WOHmX/D6BjSh5vkqIiB6DSoMsNw=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <4B059150.5050303@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135893>

Junio, could you tell us what happened to this thread?
