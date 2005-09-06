From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: git/gitweb - feature request: Add description to the branches.
Date: Tue, 06 Sep 2005 15:21:20 +0200
Message-ID: <87ll2aib73.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 15:23:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECdNu-00020k-W2
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 15:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVIFNVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVIFNVG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 09:21:06 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:36485 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964858AbVIFNVF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 09:21:05 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j86DKwi29135;
	Tue, 6 Sep 2005 15:21:00 +0200
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8130>

Hi:

        First, thank you for this great tool.

        One thing I'm missing is a way to describe a branch. It can be
        done in the $GIT_DIR/description, the first line for the whole
        repository and the rest for the branches. So description file
        for the git.git repository could be:

[description]
The core git plumbing
pu: Proposed updates
rc: Release candidate
todo: Todo list
[/description]

        And it can be added to the gitweb tool.

        Thanks.

        Santi
