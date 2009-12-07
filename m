From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 2/2] Add a command "fixup" to rebase --interactive
Date: Mon, 07 Dec 2009 12:41:58 +0100
Message-ID: <4B1CEA06.6030704@alum.mit.edu>
References: <cover.1260099005.git.mhagger@alum.mit.edu> <ced6765cff6225a05f196a6896ab577850979ab1.1260099005.git.mhagger@alum.mit.edu> <fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 12:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbzM-0004Gv-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934262AbZLGLmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934159AbZLGLmO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:42:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33527 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934262AbZLGLmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 06:42:13 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB7Bfwfw014592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Dec 2009 12:41:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134750>

Sverre Rabbelier wrote:
> On Mon, Dec 7, 2009 at 05:22, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The command is like "squash", except that it discards the commit message
>> of the corresponding commit.
> 
> No no, wait, wasn't "fixup" supposed to let you just edit the commit
> message of the commit you're fixing up? :(

That command is called "reword".

Michael
