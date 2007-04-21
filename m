From: Michael <barra_cuda@katamail.com>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 22:01:39 +0200
Message-ID: <200704212201.39306.barra_cuda@katamail.com>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com> <200704211654.16393.barra_cuda@katamail.com> <Pine.LNX.4.64.0704211703340.20005@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 21 21:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfLk3-0005Ua-Dl
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 21:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbXDUT72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXDUT72
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 15:59:28 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:35527 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbXDUT72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 15:59:28 -0400
Received: from dial-up-mi-436.lombardiacom.it ([::ffff:212.34.226.182]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.226.182+RyOmM8q4bP; Sat, 21 Apr 2007 21:59:24 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0704211703340.20005@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45191>

Julian Phillips wrote:
> In the git repo, try this:
> 
> git show 41bdcda37376a5faa63028f01260890723c3fcfa -- git-gui.sh
> 
> ;)

I forgot that git could search in that history too...

btw:

git grep full-history Documentation/* | wc -l
0
