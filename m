From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 04 Feb 2008 02:11:40 +0200
Organization: Private
Message-ID: <zluh1sxv.fsf@blue.sea.net>
References: <prvd3i9e.fsf@blue.sea.net> <ir15399p.fsf@blue.sea.net>
	<m3lk6161jo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLox4-0002ee-Vb
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbYBDAMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbYBDAMO
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:12:14 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:58222 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbYBDAMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:12:14 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 90D8FEBE46;
	Mon,  4 Feb 2008 02:12:12 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A048E285871; Mon, 04 Feb 2008 02:12:12 +0200
Received: from cante.net (a91-155-178-181.elisa-laajakaista.fi [91.155.178.181])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 5DD7EE5EE6;
	Mon,  4 Feb 2008 02:12:10 +0200 (EET)
In-Reply-To: <m3lk6161jo.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sun, 03 Feb 2008 15:52:23 -0800 (PST)")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72429>

* Sun 2008-02-03 Jakub Narebski <jnareb@gmail.com> INBOX
> I would say "[--whitespace=<option>]" or "[--whitespace=<action>]"
> instead of introducing yet not agreed upon notation (this has the
> advantage of shortening synopisis, which should be short IMHO).

The "{a|b|c}" is a used syntax. See cpio(1).
 
    cpio  {-o|--create} [-0acvABLV] ...

The information about values to --whitespace is buried under 2 manual
pages. A help that displays the values immediately is more helpful. The
--whitespace option is used very frequently.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
