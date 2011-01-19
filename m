From: flebber <flebber.crue@gmail.com>
Subject: Re: Locating Git Clone
Date: Wed, 19 Jan 2011 00:57:29 -0800 (PST)
Message-ID: <1295427449605-5938759.post@n2.nabble.com>
References: <1295426139368-5938712.post@n2.nabble.com> <loom.20110119T094539-141@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 09:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfTrG-0005AR-1L
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 09:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab1ASI5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 03:57:31 -0500
Received: from sam.nabble.com ([216.139.236.26]:60939 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054Ab1ASI5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 03:57:30 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <flebber.crue@gmail.com>)
	id 1PfTr7-0005Rz-Jr
	for git@vger.kernel.org; Wed, 19 Jan 2011 00:57:29 -0800
In-Reply-To: <loom.20110119T094539-141@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165247>


So how can I determine which folder is set for git? Should I have declared
the folder to clone to in the orginal clone command?

I tried using --get-dir and the man.

renshaw@RENSHAWRESIDENC ~
$ --git-dir
sh.exe": --git-dir: command not found

renshaw@RENSHAWRESIDENC ~
$ --git-dir=GIT_DIR
sh.exe": --git-dir=GIT_DIR: command not found

renshaw@RENSHAWRESIDENC ~
$ help mv
sh.exe": help: no help topics match `mv'.  Try `help help'
fo mv'.

renshaw@RENSHAWRESIDENC ~
$ man -k mv
sh.exe": man: command not found

renshaw@RENSHAWRESIDENC ~
$ info mv
sh.exe": info: command not found

renshaw@RENSHAWRESIDENC ~
$ mv grails-1.3.6 c:\grails
mv: cannot stat `grails-1.3.6': No such file or directory
-- 
View this message in context: http://git.661346.n2.nabble.com/Locating-Git-Clone-tp5938712p5938759.html
Sent from the git mailing list archive at Nabble.com.
