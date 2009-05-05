From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: still getting 'It is a submodule!" in 1.6.2.5
Date: Tue, 05 May 2009 11:23:50 -0400
Message-ID: <4A005A06.6040209@brooklynpenguin.com>
References: <gtnjq8$317$1@ger.gmane.org> <7vy6tc2gnt.fsf@alter.siamese.dyndns.org> <4A004BCA.5070709@brooklynpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue May 05 17:24:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1MUx-0002g8-Rb
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 17:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZEEPXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 11:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZEEPXx
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 11:23:53 -0400
Received: from mail201.messagelabs.com ([216.82.254.211]:37991 "EHLO
	mail201.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZEEPXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 11:23:52 -0400
X-VirusChecked: Checked
X-Env-Sender: tim@brooklynpenguin.com
X-Msg-Ref: server-13.tower-201.messagelabs.com!1241537031!32627151!1
X-StarScan-Version: 6.0.0; banners=.,-,-
X-Originating-IP: [76.8.67.2]
Received: (qmail 10491 invoked from network); 5 May 2009 15:23:52 -0000
Received: from cyrus.limewire.com (HELO cyrus.limewire.com) (76.8.67.2)
  by server-13.tower-201.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 5 May 2009 15:23:52 -0000
Received: from [10.254.0.107] (tolsen@neurofunk.limewire.com [10.254.0.107])
	(authenticated bits=0)
	by cyrus.limewire.com (8.13.1/8.13.1) with ESMTP id n45FNnEU002894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 5 May 2009 11:23:49 -0400
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4A004BCA.5070709@brooklynpenguin.com>
X-Spam-Score: undef - tim@brooklynpenguin.com is whitelisted.
X-CanItPRO-Stream: default
X-Canit-Stats-ID: Bayes signature not available
X-Scanned-By: CanIt (www . roaringpenguin . com) on 10.254.0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118301>

Tim Olsen wrote:
> Thanks Junio for your reply.  We have made a copy of the offending
> branch by hand and have managed to merge that instead for now.  I can
> wait until 1.6.3 is released.

I changed my mind and decided to try out 1.6.3.rc4.  I can confirm that
the bug is fixed.  Thanks!

Tim

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
