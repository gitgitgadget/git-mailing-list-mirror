From: Nelson Elhage <nelhage@MIT.EDU>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sun, 13 Sep 2009 13:07:23 -0400
Message-ID: <20090913170723.GS4275@mit.edu>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu> <7vfxar5zsi.fsf@alter.siamese.dyndns.org> <20090913034031.GO4275@mit.edu> <20090913035421.GP4275@mit.edu> <7vd45v2za4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 19:07:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmsXz-0004tU-TE
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 19:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbZIMRHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 13:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbZIMRHX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 13:07:23 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63170 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755017AbZIMRHW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 13:07:22 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8DH7O5M013427;
	Sun, 13 Sep 2009 13:07:24 -0400 (EDT)
Received: from LUNATIQUE.MIT.EDU (LUNATIQUE.MIT.EDU [18.208.0.153])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8DH7Nef017012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Sep 2009 13:07:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd45v2za4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128374>

On Sat, Sep 12, 2009 at 10:23:47PM -0700, Junio C Hamano wrote:
> Nelson Elhage <nelhage@MIT.EDU> writes:
> 
> > ... I think my
> > general argument still stands for commands where that is not the case.
> 
> Cool down.
> 
> It is a mere subset of what I already said, so you are not arguing against
> me at all.

My apologies for continuing an argument where there was none. I've
sent a patch with an improved commit message, and we can continue
discussing on that thread if necessary.

- Nelson
