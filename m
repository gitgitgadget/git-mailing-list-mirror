From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC v2 1/2] git-p4: small improvements to
 user-preservation
Date: Mon, 9 May 2011 18:30:48 -0400
Message-ID: <20110509223048.GA1716@arf.padd.com>
References: <1304923203-26278-1-git-send-email-luke@diamand.org>
 <1304923203-26278-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue May 10 00:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYyq-0008KJ-Px
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1EIWbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:31:03 -0400
Received: from honk.padd.com ([74.3.171.149]:45199 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128Ab1EIWbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:31:02 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id F25D720B7;
	Mon,  9 May 2011 15:31:00 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E39845AA98; Mon,  9 May 2011 18:30:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1304923203-26278-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173277>

luke@diamand.org wrote on Mon, 09 May 2011 07:40 +0100:
> . Slightly more paranoid checking of results from 'p4 change'
> . Remove superfluous "-G"
> . Don't modify the username if it is unchanged.
> . Reword git-p4.txt to point out that the initial commit will
>   be submitted with you as the author.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>

Acked-By: Pete Wyckoff <pw@padd.com>
