From: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Subject: Pure renames/copies
Date: Mon, 21 Nov 2005 13:01:03 +0100
Message-ID: <87hda61a80.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 21 13:02:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeAKx-0005lm-D9
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 12:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVKUL7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 06:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVKUL7u
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 06:59:50 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:42717 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932272AbVKUL7t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 06:59:49 -0500
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jALBxgZ23853
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 12:59:47 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12440>

Hello:


        Is there any way to ask git to find pure renames or copies?

        I ask this because it is a much cheaper operation than the -C
        and -M do (-M100 does not work) and can be used when the number
        of paths if big, or when you track binary files.

        Thanks

        Santi
