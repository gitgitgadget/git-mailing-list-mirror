From: layer <layer@known.net>
Subject: Re: I want to omit the commit log message from the log output
Date: Wed, 27 Oct 2010 13:26:21 -0700
Message-ID: <20638.1288211181@relay.known.net>
References: <18995.1288205882@relay.known.net> <20101027193650.GA24934@burratino>
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 22:26:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBCZn-0007Aj-2u
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 22:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab0J0U0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 16:26:23 -0400
Received: from relay.known.net ([173.13.135.57]:38266 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111Ab0J0U0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 16:26:22 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000133643; Wed, 27 Oct 2010 13:26:21 -0700
In-reply-to: <20101027193650.GA24934@burratino>
Comments: In-reply-to Jonathan Nieder <jrnieder@gmail.com>
   message dated "Wed, 27 Oct 2010 14:36:50 -0500."
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160121>

Looks like 

  git diff-tree --cc --summary --stat --no-commit-id origin/master..HEAD

is what I want.

Thanks!
