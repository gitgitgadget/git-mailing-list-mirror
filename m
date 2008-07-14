From: Mark Burton <markb@ordern.com>
Subject: Git describe question
Date: Mon, 14 Jul 2008 08:55:57 +0100
Organization: Order N Ltd.
Message-ID: <20080714085557.246f52b9@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 09:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIIvj-0004Or-Cx
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 09:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbYGNH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbYGNH4I
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 03:56:08 -0400
Received: from c2bthomr09.btconnect.com ([213.123.20.127]:2115 "EHLO
	c2bthomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbYGNH4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 03:56:07 -0400
Received: from crow.ordern.com (host86-128-141-55.range86-128.btcentralplus.com [86.128.141.55])
	by c2bthomr09.btconnect.com
	with ESMTP id BJG31342;
	Mon, 14 Jul 2008 08:55:58 +0100 (BST)
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id AA220190D3E
	for <git@vger.kernel.org>; Mon, 14 Jul 2008 08:55:57 +0100 (BST)
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090201.487B0694.0108,ss=1,fgs=0,
	ip=86.128.141.55,
	so=2007-10-30 19:00:17,
	dmn=5.4.3/2008-02-01
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88394>

Hi,

Having just pulled the latest updates, git describe says:

v1.5.6.3-315-g10ce020

Why does it think there are 315 commits on top of the v1.5.6.3 tag? I
would have expected a much smaller number than that.

Thanks,

Mark
