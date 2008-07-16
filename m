From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/5] add pack index v2 reading capability to git v1.4.4.4
Date: Wed, 16 Jul 2008 02:31:34 -0400
Message-ID: <1216189899-14279-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 08:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ0Z5-0006PH-Gz
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 08:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYGPGbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 02:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYGPGbk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 02:31:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11927 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYGPGbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 02:31:40 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K43006BG64RTN50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 Jul 2008 02:31:39 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.3.499.geae9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88641>

Well, here it is.  I know I know, I'm just too nice.  Oh well...

This is the minimum set of backported patches on top of git v1.4.4.4
to allow it to cope with pack index version 2.

Junio: if you could just apply them, tag the result as v1.4.4.5 and
push it out then at that point it simply will be up to Debian to make
it available as a "major usability fix".


Nicolas
