From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: chmod +x po2msg
Date: Tue, 21 Jan 2014 22:13:57 +1100
Message-ID: <20140121111357.GD8265@iris.ozlabs.ibm.com>
References: <xmqqsiubqd78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 12:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5ZMb-0007zu-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 12:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbaAULTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 06:19:21 -0500
Received: from ozlabs.org ([203.10.76.45]:46188 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbaAULTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 06:19:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5D1EC2C0081; Tue, 21 Jan 2014 22:19:18 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqsiubqd78.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240749>

On Mon, Dec 02, 2013 at 11:12:43AM -0800, Junio C Hamano wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
> Date: Mon, 25 Nov 2013 13:00:10 -0800
> 
> The Makefile only runs it using tclsh, but because the fallback po2msg
> script has the usual tcl preamble starting with #!/bin/sh it can also
> be run directly.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, applied.

Paul.
