From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 4/9] contrib: remove git-p4import
Date: Tue, 26 Nov 2013 07:31:59 -0500
Message-ID: <20131126123159.GA22601@padd.com>
References: <20131125205119.GQ4212@google.com>
 <20131125205847.GU4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sean Estabrooks <seanlkml@sympatico.ca>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 13:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlHoG-0006dO-JY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 13:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab3KZMcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 07:32:05 -0500
Received: from honk.padd.com ([74.3.171.149]:51883 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab3KZMcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 07:32:03 -0500
Received: from arf.padd.com (unknown [50.105.7.175])
	by honk.padd.com (Postfix) with ESMTPSA id 502B85D7;
	Tue, 26 Nov 2013 04:32:02 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2408820C3F; Tue, 26 Nov 2013 07:31:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131125205847.GU4212@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238381>

jrnieder@gmail.com wrote on Mon, 25 Nov 2013 12:58 -0800:
> The git p4import documentation has suggested git p4 as a better
> alternative for more than 6 years.  (According to the mailing list
> discussion when it was moved to contrib/, git-p4import has serious
> bugs --- e.g., its incremental mode just doesn't work.) Since then,
> git p4 has been actively developed and was promoted to a standard git
> command alongside git svn.
> 
> Searches on google.com/trends and stackoverflow suggest that no one is
> looking for git-p4import any more.  Remove it.
> 
> Noticed while considering marking the contrib/p4import/git-p4import.py
> script executable as part of a wider sweep.

I haven't seen git-p4import mentioned for the last 6 years either.
Thanks,

Acked-by: Pete Wyckoff <pw@padd.com> 
