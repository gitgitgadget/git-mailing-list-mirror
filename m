From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Wed, 13 Oct 2010 00:46:42 -0700 (PDT)
Message-ID: <1286956002591-5629905.post@n2.nabble.com>
References: <20100813094027.GA20906@localhost> <20100813200031.GD2003@burratino> <20100813212331.GA24127@localhost> <20100813213726.GB2516@burratino> <20100813215801.GA24534@localhost> <20100815072043.GA368@localhost> <1284095850.1728.5.camel@n900.home.ru> <20100910081626.GA30507@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 09:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5w3O-0005ZI-Ds
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 09:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0JMHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 03:46:47 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36522 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0JMHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 03:46:46 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P5w2s-0008Pb-JF
	for git@vger.kernel.org; Wed, 13 Oct 2010 00:46:42 -0700
In-Reply-To: <20100910081626.GA30507@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158909>


So, here's some gprof data of git-rev-list:
http://git.661346.n2.nabble.com/file/n5629905/gprof_-p.txt gprof -p output 
http://git.661346.n2.nabble.com/file/n5629905/gprof_-q.txt gprof -q output 
-- 
View this message in context: http://git.661346.n2.nabble.com/PATCH-hash-binary-sha1-into-patch-id-tp5419375p5629905.html
Sent from the git mailing list archive at Nabble.com.
