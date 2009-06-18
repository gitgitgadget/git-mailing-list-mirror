From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for
 the given branches
Date: Thu, 18 Jun 2009 13:52:29 +0200
Message-ID: <4A3A2A7D.30502@gnu.org>
References: <1245311834-5290-1-git-send-email-santi@agolina.net> <1245311834-5290-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHGAp-0003g1-Jm
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 13:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762000AbZFRLwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 07:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761654AbZFRLwk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 07:52:40 -0400
Received: from mx2.redhat.com ([66.187.237.31]:44907 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760955AbZFRLwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 07:52:39 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5IBqfMV021201;
	Thu, 18 Jun 2009 07:52:41 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5IBqeF4026187;
	Thu, 18 Jun 2009 07:52:40 -0400
Received: from yakj.usersys.redhat.com (dhcp-lab-149.englab.brq.redhat.com [10.34.33.149])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5IBqdnm010444;
	Thu, 18 Jun 2009 07:52:39 -0400
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <1245311834-5290-2-git-send-email-santi@agolina.net>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121831>

Having a testcase would be nice (just a reminder for the final submission).

Paolo
