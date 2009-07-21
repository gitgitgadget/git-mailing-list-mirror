From: Roald de Vries <rdv@roalddevries.nl>
Subject: vimrc
Date: Tue, 21 Jul 2009 12:09:33 +0200
Message-ID: <0EBD460B-AA87-44AD-A98C-86787F3BA91A@roalddevries.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 12:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTCIn-0002CC-G6
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 12:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbZGUKKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 06:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbZGUKKV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 06:10:21 -0400
Received: from platinum.liacs.nl ([132.229.131.22]:38497 "EHLO
	platinum.liacs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZGUKKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 06:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6LAAHKF025703
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 12:10:19 +0200
X-Virus-Scanned: amavisd-new at liacs.nl
Received: from platinum.liacs.nl ([127.0.0.1])
	by localhost (platinum.liacs.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZvL9uvYHfolX for <git@vger.kernel.org>;
	Tue, 21 Jul 2009 12:09:57 +0200 (CEST)
Received: from prive147.liacs.nl (prive147.liacs.nl [132.229.16.147])
	by platinum.liacs.nl (8.14.2/8.14.2/LIACS 1.5) with ESMTP id n6LA9cdN025585
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 12:09:39 +0200
X-Mailer: Apple Mail (2.935.3)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (platinum.liacs.nl [132.229.131.22]); Tue, 21 Jul 2009 12:09:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123654>

Hi all,

I have my ~/.vimrc in a repository, and if I commit something, I get:

$ git commit
Error detected while processing /home/rdv/.vimrc:
line   11:
E518: Unknown option: foldmethod=indent
line   12:
E518: Unknown option: foldlevel=10
line   13:
E518: Unknown option: foldcolumn=4
line   16:
E538: No mouse support: mouse=a

Anybody knows why? It doesn't seem to break anything, but still...

Kind regards, Roald
