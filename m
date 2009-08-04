From: Michael Wild <themiwi@users.sourceforge.net>
Subject: Re: conflict status
Date: Tue, 4 Aug 2009 09:31:13 +0200
Message-ID: <398EA050-EEC9-4C16-8225-410BBECABB13@users.sourceforge.net>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net> <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com> <200908032017.35101.trast@student.ethz.ch> <7vvdl4925k.fsf@alter.siamese.dyndns.org> <4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net> <m34osoqc5p.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEUs-0006UQ-VL
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbZHDHbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbZHDHbS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:31:18 -0400
Received: from mxout006.mail.hostpoint.ch ([217.26.49.185]:56309 "EHLO
	mxout006.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932509AbZHDHbR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 03:31:17 -0400
Received: from [10.0.2.10] (helo=asmtp001.mail.hostpoint.ch)
	by mxout006.mail.hostpoint.ch with esmtp (Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MYEUN-0004fi-4m; Tue, 04 Aug 2009 09:31:15 +0200
Received: from [82.130.106.80] (helo=nynaeve.ifd.mavt.ethz.ch)
	by asmtp001.mail.hostpoint.ch with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <themiwi@users.sourceforge.net>)
	id 1MYEUN-000OWX-12; Tue, 04 Aug 2009 09:31:15 +0200
X-Authenticated-Sender-Id: mi@miba.li
In-Reply-To: <m34osoqc5p.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124767>


On 4. Aug, 2009, at 9:19, Jakub Narebski wrote:
>
> If you don't need SHA-1s, why not use -t or -v option of git-ls-files,
> e.g.:
>
>  $ git ls-files -v -u
>


Huh? Sorry, I don't get your point. -v and -t will just prefix a  
"M" (or sometimes "m" in the case of-v) for unmerged files. But I  
already know they are unmerged, so why bother?
