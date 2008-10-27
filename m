From: "Leslie P. Polzer" <sky@viridian-project.de>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 11:12:27 +0100 (CET)
Message-ID: <62339.88.73.238.241.1225102347.squirrel@mail.stardawn.org>
References: <ge0rla$mce$1@ger.gmane.org>
    <200810270252.23392.jnareb@gmail.com>
    <200810270850.09696.arne_bab@web.de>
    <200810271041.54511.jnareb@gmail.com>
Reply-To: leslie.polzer@gmx.net
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "Arne Babenhauserheide" <arne_bab@web.de>, slonik.az@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:42:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuPYT-0002T2-LT
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYJ0KlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 06:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbYJ0KlV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:41:21 -0400
Received: from viridian-project.de ([89.149.208.197]:34621 "EHLO
	viridian-project.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYJ0KlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 06:41:21 -0400
X-Greylist: delayed 1729 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Oct 2008 06:41:20 EDT
Received: from localhost ([127.0.0.1]:34584 helo=mail.stardawn.org)
	by viridian-project.de with esmtp (Exim 4.63)
	(envelope-from <sky@viridian-project.de>)
	id 1KuP5H-0001oC-UR; Mon, 27 Oct 2008 11:12:28 +0100
Received: from 88.73.238.241
        (SquirrelMail authenticated user sky)
        by mail.stardawn.org with HTTP;
        Mon, 27 Oct 2008 11:12:27 +0100 (CET)
In-Reply-To: <200810271041.54511.jnareb@gmail.com>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99224>


> I'm not sure if I should have mentioned transactions in databases here.
> Oh, well... Note however that there are advanced way of doing
> transactions in relational databases which lead to dangling things
> to be purged when transaction is interrupted.

For the record: transactions are applicable to all kinds of databases,
not only relational ones.

  Leslie
