From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Avoid unnecessary "if-before-free" tests.
Date: Wed, 20 Feb 2008 17:57:51 +0100
Message-ID: <871w77ftv4.fsf@rho.meyering.net>
References: <20080220102644.9832A502C412@sam.corp.sgi.com>
	<20080220103317.a227ff88.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Paul Jackson <pj@sgi.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 17:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRsI5-0008Az-FW
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 17:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbYBTQ6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 11:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYBTQ6Y
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 11:58:24 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60848 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbYBTQ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 11:58:23 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1E64A17B581
	for <git@vger.kernel.org>; Wed, 20 Feb 2008 17:58:22 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ECFE617B52F
	for <git@vger.kernel.org>; Wed, 20 Feb 2008 17:58:21 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7ECC833517;
	Wed, 20 Feb 2008 17:57:51 +0100 (CET)
In-Reply-To: <20080220103317.a227ff88.pj@sgi.com> (Paul Jackson's message of
	"Wed, 20 Feb 2008 10:33:17 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74524>

Paul Jackson <pj@sgi.com> wrote:
> Could you tell me to whom you sent this PATCH?

Hi Paul,
Sure.  It was to git@vger.kernel.org:

  http://thread.gmane.org/gmane.comp.version-control.git/74187/focus=74506

Sounds like it went through a buggy version of mailman (like 1.1.5 :-).
