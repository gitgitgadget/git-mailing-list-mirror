From: jidanni@jidanni.org
Subject: git-doc CSS dependent, breaks down in text browsers
Date: Fri, 12 Dec 2008 04:29:14 +0800
Message-ID: <87wse6zc9x.fsf@jidanni.org>
References: <87ej0qf3gx.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 21:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsBC-0006m9-FG
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998AbYLKU3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbYLKU3S
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:29:18 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:40548 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756160AbYLKU3R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 15:29:17 -0500
Received: from jidanni1.jidanni.org (122-127-32-244.dynamic.hinet.net [122.127.32.244])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 9A743119E1A
	for <git@vger.kernel.org>; Thu, 11 Dec 2008 12:29:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102818>

E.g., pages look like

SYNOPSIS

git-config [<file-option>] [type] [-z|--null] name [value [value_regex]] git-config [<file-option>] [type] --add name
value git-config [<file-option>] [type] --replace-all name [value [value_regex]] git-config [<file-option>] [type] [-z|
--null] --get name [value_regex] git-config [<file-option>] [type] [-z|--null] --get-all name [value_regex] git-config...

Please see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507475 ,
which was supposed to be forwarded to git@vger.kernel.org but wasn't,
apparently.
