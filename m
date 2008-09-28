From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/8] Docs: send-email: Man page option ordering
Date: Sun, 28 Sep 2008 14:04:36 -0500
Message-ID: <FB3A852B-728F-4183-A5AF-BA8F8D995AD7@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <gbne1a$8g2$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1aa-0005rj-Ac
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYI1TEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYI1TEk
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:04:40 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37975 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255AbYI1TEj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 15:04:39 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8SJ4bHL027161;
	Sun, 28 Sep 2008 15:04:37 -0400 (EDT)
Received: from [192.168.0.65] (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8SJ3K6F015113
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 28 Sep 2008 15:04:36 -0400 (EDT)
In-Reply-To: <gbne1a$8g2$1@ger.gmane.org>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96979>


On 28 Sep 2008, at 3:08 AM, Jakub Narebski wrote:

> Michael Witten wrote:
>
>> Now the man page lists the options in alphabetical
>> order (in terms of the 'main' part of an option's
>> name).
>
> I know it is a matter of taste, but I prefer having options
> on man page in functional order, grouped by function, perhaps
> with subsections to group them (c.f. git-rev-list man page).

See: http://marc.info/?l=git&m=122246885210923&w=2
