From: jidanni@jidanni.org
Subject: Re: git-gui: the UTF-8 characters are shown as garbage
Date: Tue, 13 Jan 2009 10:24:22 +0800
Message-ID: <87vdskndt5.fsf@jidanni.org>
References: <20080901221138.6458.4316.reportbug@ant.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 497469@bugs.debian.org, git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Jan 13 03:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYyU-0004dU-4o
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 03:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbZAMCYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 21:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZAMCYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 21:24:25 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:44605 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751193AbZAMCYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 21:24:25 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 7A1FEC482B;
	Mon, 12 Jan 2009 18:24:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105444>

As in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=497469
I also see junk with e.g.,
$ git gui blame git-gui/po/zh_cn.po
