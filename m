From: Andy Green <andy@warmcat.com>
Subject: Re: StGIT munged path on refresh
Date: Mon, 04 Jun 2007 11:36:56 +0100
Message-ID: <4663EB48.3020302@warmcat.com>
References: <4663CC54.7090203@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 04 12:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv9wJ-0005qK-5H
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 12:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbXFDKhA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 06:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbXFDKhA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 06:37:00 -0400
Received: from mog.warmcat.com ([62.193.232.24]:34000 "EHLO
	mailserver.mog.warmcat.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924AbXFDKg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 06:36:59 -0400
Received: from armbox7.home.warmcat.com (cpc1-nthc5-0-0-cust289.nrth.cable.ntl.com [82.29.29.34])
	by mailserver.mog.warmcat.com (Postfix) with ESMTP id AE8F98CAD8;
	Mon,  4 Jun 2007 12:36:55 +0200 (CEST)
Received: from meerkat.home.warmcat.com (flatcat [192.168.0.77])
	by armbox7.home.warmcat.com (Postfix) with ESMTP id 9887E1AA48;
	Mon,  4 Jun 2007 10:37:05 +0000 (UTC)
Received: from meerkat.home.warmcat.com (localhost [127.0.0.1])
	by meerkat.home.warmcat.com (Postfix) with ESMTP id CE89E18D1DA1;
	Mon,  4 Jun 2007 11:36:56 +0100 (BST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <4663CC54.7090203@warmcat.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49091>

Andy Green wrote:

> I have been using quilt with some success and now I am trying to migrate
> to stgit.  I can get started okay with stg init and stg new "mypatch",

Sorry for the noise -- I found this is a FAQ, you currently have to do
the refresh at the top of the tree, unlike in quilt.

-Andy
