From: erik@aercon.net
Subject: Gmail Message rejection
Date: Mon, 09 Feb 2015 20:14:08 +0000
Message-ID: <20150209201408.Horde.2Ts12JtaemmvhMa5RcSg8w1@server.aercontechnologies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKv8p-0005bt-0m
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760968AbbBIUlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:41:07 -0500
Received: from aercontechnologies.net ([162.243.220.235]:54134 "EHLO
	server.aercontechnologies.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760944AbbBIUlF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 15:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aercon.net; s=default;
	h=MIME-Version:Content-Type:Subject:To:From:Message-ID:Date; bh=RuXPI0ja45EIibU6M0eKzbdhNEipfX4P4sItt1Zleaw=;
	b=ATwWlMicwMPQl7rT9nlY1eLpCT4RPyzzgeW6zU2KTUHCO8WOxRHxVPR3JcoPjHOsJIjXiyJmeeYxnzLPv7Z3mcI7D5TDShUH5+0Qj4xsVqDyyjfjmtJMpE7zcEWplNYAS6178+FLXxcsf3PLqsyiYPDAOD9N9DcorEGYENmUsCY=;
Received: from localhost ([::1]:60068 helo=server.aercontechnologies.net)
	by server.aercontechnologies.net with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.84)
	(envelope-from <erik@aercon.net>)
	id 1YKuif-0005xd-6Y
	for git@vger.kernel.org; Mon, 09 Feb 2015 15:14:09 -0500
Received: from 69.27.55.4 ([69.27.55.4]) by server.aercontechnologies.net
 (Horde Framework) with HTTP; Mon, 09 Feb 2015 20:14:08 +0000
User-Agent: Internet Messaging Program (IMP) H5 (6.1.4)
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.aercontechnologies.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - aercon.net
X-Get-Message-Sender-Via: server.aercontechnologies.net: authenticated_id: erik@aercon.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263592>

Can I submit this as a bug report, that sending something from the  
gmail client results in this response?

Delivery to the following recipient failed permanently:

      git@vger.kernel.org

Technical details of permanent failure:
Google tried to deliver your message, but it was rejected by the  
server for the recipient domain vger.kernel.org by vger.kernel.org.  
[209.132.180.67].

The error that the other server returned was:
550 5.7.1 Content-Policy reject msg: The message contains HTML  
subpart, therefore we consider it SPAM or Outlook Virus.  TEXT/PLAIN  
is accepted.! BF:<H 0.338318>; S932497AbbBIUIh
