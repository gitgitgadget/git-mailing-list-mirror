From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 08:42:07 +0900
Message-ID: <20090612084207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 01:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEtvD-0000fM-Oz
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667AbZFKXmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757455AbZFKXmv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:42:51 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41366 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbZFKXmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:42:51 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id DEC8D11B840
	for <git@vger.kernel.org>; Thu, 11 Jun 2009 18:42:52 -0500 (CDT)
Received: from 5042.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 6CABDVS6RU9N
	for <git@vger.kernel.org>; Thu, 11 Jun 2009 18:42:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=4XVlX903ZH3yWtlL2OuB2fThEAT2FvcCP6n5vfphzgR5b0gRFLMDAcfg1Nc/QJIdHfz23iXYbVsX9CHBTC4jwk9J4F67oaddEDR1YUyQeHS/bBSYow4uJC1cXT51nmvSFMVNVNrXYT+GV6P2thZlNDHkIHMl6HTHa6l+zChmqpY=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121375>

git provides options and configuration variables to easily handle the Signed-off-by tag line. It is used to certify that the sender certifies the patch with the Developer's Certificate of Origin.

I have read SubmittingPatches document and understand this convention is used by the Linux Kernel Project.

I was giving a git introduction to students in my lab, and this question came up from one of them. How widely is this convention used? Are there projects other than the Linux Kernel and git itself?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
