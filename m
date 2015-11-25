From: Username <user.deb@yandex.ru>
Subject: opentracker bug
Date: Wed, 25 Nov 2015 20:38:13 +0000 (UTC)
Message-ID: <loom.20151125T213715-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 21:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1grQ-0007dJ-0D
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbbKYUkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:40:14 -0500
Received: from plane.gmane.org ([80.91.229.3]:48712 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbKYUkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:40:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a1grF-0007Jd-9d
	for git@vger.kernel.org; Wed, 25 Nov 2015 21:40:05 +0100
Received: from 176.15.207.38 ([176.15.207.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 21:40:05 +0100
Received: from user.deb by 176.15.207.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 21:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 176.15.207.38 (Mozilla/5.0 (X11; Linux x86_64; rv:42.0) Gecko/20100101 Firefox/42.0 Iceweasel/42.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281740>

Hello.
I have found a bug in opentracker // http://erdgeist.org/gitweb/opentracker/
, or it is something wrong with my PC (?).

Every time when I access statistics page at
"localhost:6969/st?mode=everything", it redirects my browser to
"http://www.localhost.com:6969/st?mode=everything" and opentracker crashes
with same segmentation error. All other types (modes) of statistics work fine.

Tried different configs, users, folders, ... all the same.
Especially fun is "www" and "com" with "localhost" :)

OS Debian 8.0 Jessie amd64, opentracker was installed from sources by
instruction on the official website.

Thank you.
