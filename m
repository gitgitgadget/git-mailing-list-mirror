From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v2] git-diff: Output a warning about stale files in the
 index
Date: Tue, 07 Aug 2007 15:51:13 +0800
Message-ID: <46B82471.4090001@midwinter.com>
References: <7vbqdj9709.fsf@assigned-by-dhcp.cox.net>	<20070807071712.GA32751@midwinter.com> <7vbqdj7poi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 09:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIJqZ-0002yJ-O5
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 09:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbXHGHvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 03:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbXHGHvQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 03:51:16 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:34786 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754528AbXHGHvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 03:51:16 -0400
Received: (qmail 3088 invoked from network); 7 Aug 2007 07:51:15 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=gQGI2JHgNsR/T6EaVIvjI0k8uagwyV4KIMSD5aV1JW/mdm8eFPfgB6l74ISpRIle  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 7 Aug 2007 07:51:15 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vbqdj7poi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55231>

Junio C Hamano wrote:
> Something along the following lines, perhaps...?
>   

That seems like a fine commit message to me. My one-liner definitely 
assumed too much context, coming in the middle of this discussion as it 
did -- much better to be explicit about the reasoning for posterity's sake.

-Steve
