From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Fri, 19 Jan 2007 08:30:07 +1300
Message-ID: <46a038f90701181130p72e11368sbe61de9ceb0eada3@mail.gmail.com>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
	 <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
	 <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
	 <20070118154257.GC15428@spearce.org> <45AFA083.9050004@op5.se>
	 <20070118165107.GF15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, "Alex Riesen" <raa.lkml@gmail.com>,
	"Josh Boyer" <jwboyer@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 20:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7cyH-0007cy-IJ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 20:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXARTaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbXARTaO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 14:30:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:57423 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbXARTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 14:30:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so271961nfa
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 11:30:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koLfoDQ39llgD0A4ViXfWS2Uoc8h1r6Xx8MyBjTbaun9SjGEXVY8czONorB68ZROiwnk5Bky/roaXZkNNBwoolRW27fWkTUFG8J1oYx/OXzf/1jVIqv3bBX2NJBcrBG04/I2NO1LSNVEcY6iS5mTKPwdHyi0Uz4ZFOoZ/SuBhqk=
Received: by 10.49.29.2 with SMTP id g2mr1247261nfj.1169148607643;
        Thu, 18 Jan 2007 11:30:07 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Thu, 18 Jan 2007 11:30:07 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118165107.GF15428@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37132>

On 1/19/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Wishful thinking.  Back to reality.

Not necessarily ;-) but I'm not sure if the time is right for an
independend services company doing _only_ git.

However, git is the kind of SCM that a big distro needs to keep track
of all their "vendor branches" or "patches against upstream". Ubuntu
pays at least one full-time SCM developer, Martin Pool, to maintain
Bazaar NG and accesory tools.

IIRC MySQL was looking quite seriously to drop BK and with the savings
in licenses, can surely affort to hire a GIT guru to "train the
trainer", solve problems/bugs and write internal support tools. Others
will follow. It shouldn't be too hard to find the right place.

Or a large FOSS services focused company (like Catalyst) that uses git
and offers support as part of a larger bundle. (<spam>we're hiring,
and putting git hackery in your cv is a winner</spam>). There are
plenty of gaps and places for git hackers.

cheers


martin
