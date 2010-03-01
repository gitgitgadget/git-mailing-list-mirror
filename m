From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Creating a tarball out of a directory in a bare git repository
Date: Mon, 01 Mar 2010 23:00:15 +0000
Message-ID: <5e95aba2186b1f37f9292dadc8134bb6@212.159.54.234>
References: <27750115.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 00:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmEbA-0006sh-EV
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 00:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab0CAXAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 18:00:18 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:42623 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280Ab0CAXAR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 18:00:17 -0500
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id EA11D819C157;
	Mon,  1 Mar 2010 23:00:15 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C6385222D72;
	Mon,  1 Mar 2010 23:00:15 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FtqFyIACTn7a; Mon,  1 Mar 2010 23:00:15 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 6D66535E17;
	Mon,  1 Mar 2010 23:00:15 +0000 (GMT)
In-Reply-To: <27750115.post@talk.nabble.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141366>

On Mon, 1 Mar 2010 14:47:45 -0800 (PST), jateeq <jawad_atiq@hotmail.com>
wrote:
> Hello,
> 
> I am developing a web interface, part of which allows the user to
download
> a
> tarball of a directory (which is in a bare repostitory on the
filesystem)
> on
> clicking on a link.
[..snip..]
> I hope someone has a much simpler answer to this problem!

Have a look at "git archive":

http://www.kernel.org/pub/software/scm/git/docs/git-archive.html

-- 
Julian
