From: Nicolas Pitre <nico@cam.org>
Subject: my recent patches
Date: Thu, 06 Sep 2007 02:19:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709060215350.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 08:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITAi9-0002vX-30
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 08:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbXIFGTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 02:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbXIFGTY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 02:19:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46254 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbXIFGTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 02:19:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00FV3O8BY7C0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 02:19:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57829>

I forgot to have them numbered, so here is the proper order:

1- "[PATCH] straighten the list of objects to deltify"
2- "[PATCH] localize window memory usage accounting"
3- "[PATCH] rearrange delta search progress reporting"
4- "[PATCH] basic threaded delta search"

Based on top of "next".


Nicolas
