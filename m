From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH/RFC 0/2] Lazily generate header dependencies
Date: Fri, 01 Jan 2010 09:05:50 +0900
Message-ID: <20100101090550.6117@nanako3.lavabit.com>
References: <4B0F8825.3040107@viscovery.net> <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302> <20091127174558.GA3461@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 01:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQV1p-00069l-Hw
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab0AAAF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031Ab0AAAFz
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:05:55 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44448 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab0AAAFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 19:05:55 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id EEC6411B89C;
	Thu, 31 Dec 2009 18:05:54 -0600 (CST)
Received: from 8965.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id VHO97MEI2MA9; Thu, 31 Dec 2009 18:05:54 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=0Uq9Og9xYVlxabBQPISDTVpfZiswvc0a8NpfQWVPRcDxfhZaX9rS8kOa6hFqNzfLcTDF/W4+bsgiSYxxk/1inUxwQmT/bfxd71XeEwcRYi5BUw+lCnNCVCZOLSz4DHi8oCiAsAgy4MRF0dMe8mlAnqg11lN3a43IhyVmG6BHKPE=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <20091127174558.GA3461@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135987>

Junio, could you tell us what happened to this thread?

Makefile improvements.  No discussion.
