From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Using git from Python
Date: Wed, 7 May 2008 17:18:42 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 02:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JttrH-0006gU-Ol
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 02:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbYEHASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYEHASt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 20:18:49 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:37146 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbYEHASs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 20:18:48 -0400
Received: from sf.creativecommons.org (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 31850A0110
	for <git@vger.kernel.org>; Wed,  7 May 2008 20:18:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTP id 126D1E1E086
	for <git@vger.kernel.org>; Wed,  7 May 2008 17:18:43 -0700 (PDT)
X-X-Sender: paulproteus@sf.creativecommons.org
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81494>

>From a Python app, I want to read and write a git repository.  It seems 
from Luiz Fernando's post at http://blog.cpu.eti.br/?p=91 that the efforts 
to Pythonize libgit have stalled.

On #git, I was advised to simply call the git command suite.  That's fine, 
and I can do it using the subprocess module in Python - but since I 
figured others may have done this also, does anyone know of a Python 
module that wraps some git commands?  I'm thinking if others have gone 
down this path, they might have code that e.g. raises Exceptions when the 
git commands fail for some reason.

What have others on this list done lately for using git from Python?

-- Asheesh.

-- 
You will reach the highest possible point in your business or profession.
