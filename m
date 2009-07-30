From: Josh ben Jore <jbenjore@whitepages.com>
Subject: Re: Merge-base algorithm?
Date: Thu, 30 Jul 2009 11:42:19 -0700
Message-ID: <C697379B.61EB1%jbenjore@whitepages.com>
References: <D5F958F92101F74D8A5683C2FE14F4200F231037@post.corp.w3data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 20:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWaaE-0005nV-Am
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbZG3SmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbZG3SmV
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 14:42:21 -0400
Received: from mail0.w3data.com ([38.112.225.178]:55980 "EHLO
	hub.corp.w3data.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751234AbZG3SmV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 14:42:21 -0400
Received: from post.corp.w3data.com ([172.18.0.206]) by hub ([172.25.0.29])
 with mapi; Thu, 30 Jul 2009 11:42:27 -0700
Thread-Topic: Merge-base algorithm?
Thread-Index: AcoQzIQSjevrlqlLToKhEgVwQ+ZTkAAePOA/
In-Reply-To: <D5F958F92101F74D8A5683C2FE14F4200F231037@post.corp.w3data.com>
Accept-Language: en-US
Content-Language: en
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124477>

On 7/29/09 9:16 PM, "Josh ben Jore" <jbenjore@whitepages.com> wrote:

> What is the merge-base algorithm for selecting nodes?

Oops, my /opt/git/bin/git merge-base --help on the approximately 1.6.4 was
using the documentation from the other git in /usr/bin/git. While reading
the source tree, I found Documentation/git-merge-base.txt which answered
this question.

The docs I'd read still said to read the source code.

Josh
