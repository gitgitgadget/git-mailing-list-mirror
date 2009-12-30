From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after printing the report line
Date: Wed, 30 Dec 2009 22:41:22 +0900
Message-ID: <20091230224122.6117@nanako3.lavabit.com>
References: <loom.20091119T221732-624@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Thiel <byronimo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPyo9-0005Nc-8d
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 14:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZL3Nl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 08:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZL3Nl3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 08:41:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52794 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbZL3Nl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 08:41:28 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 9251C11B85A;
	Wed, 30 Dec 2009 07:41:28 -0600 (CST)
Received: from 9478.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 658WU1PCTH40; Wed, 30 Dec 2009 07:41:28 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=aSEeZUmduhzC9zh1O7Akxn/Vwzum+3jeiPkL3Dog/TWYHj5oav2SvnLZXmZUmCfS3E3kjOeE8eR8CGoWbVqs3t5jpSWa7zPDdSxEvInHpoaPY0ltt/iIAQNvLFP9fKgoOZ+sHmGNh3bEV7j6Zo+V0EgtkYVHILa44XDNzKWfUwg=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <loom.20091119T221732-624@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135894>

Junio, could you tell us what happened to this thread?
