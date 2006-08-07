From: Bryan O'Sullivan <bos@serpentine.com>
Subject: RE: Problem with clone hanging
Date: Mon, 07 Aug 2006 15:34:18 -0700
Message-ID: <1154990058.26375.106.camel@sardonyx>
References: <6AB138A2AB8C8E4A98B9C0C3D52670E301FA761E@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Aug 08 00:33:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADf4-0000Wn-IR
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHGWdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWHGWdX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:33:23 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:13761 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932284AbWHGWdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:33:23 -0400
Received: from [127.0.0.1] (demesne.serpentine.com [192.168.16.11])
	by demesne.serpentine.com (Postfix) with ESMTP id 6BE6420B541;
	Mon,  7 Aug 2006 15:33:19 -0700 (PDT)
To: Tziporet Koren <tziporet@mellanox.co.il>
In-Reply-To: <6AB138A2AB8C8E4A98B9C0C3D52670E301FA761E@mtlexch01.mtl.com>
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25050>

On Mon, 2006-08-07 at 21:57 +0300, Tziporet Koren wrote:
> OK we will upgrade our git installation (but it will be only tomorrow)
> You are correct - we have not set HTTP interface.

It's OK - Sergey's workaround did the trick for me.

	<b
