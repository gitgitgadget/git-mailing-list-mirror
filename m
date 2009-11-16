From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep
 for 	fixed-strings
Date: Mon, 16 Nov 2009 12:00:12 -0600
Message-ID: <UENI3LuferIx-aKjVXiKMWqGarArdQQZ0OBA6OkGt_JEiX2iS4H8Wg@cipher.nrlssc.navy.mil>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>	 <20091116195050.6117@nanako3.lavabit.com>	 <20091116162533.GA30737@coredump.intra.peff.net> <d1c0fbfa0911160858k2cdd35bfvf27df2a5c97348ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Collins <bricollins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 19:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA5zO-0004pW-4i
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 19:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbZKPSHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 13:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbZKPSHe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 13:07:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34471 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbZKPSHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 13:07:33 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2009 13:07:33 EST
Received: by mail.nrlssc.navy.mil id nAGI0COm024619; Mon, 16 Nov 2009 12:00:12 -0600
In-Reply-To: <d1c0fbfa0911160858k2cdd35bfvf27df2a5c97348ad@mail.gmail.com>
X-OriginalArrivalTime: 16 Nov 2009 18:00:12.0625 (UTC) FILETIME=[A4C33C10:01CA66E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133020>

Brian Collins wrote:
>>  1. The patch was line-wrapped; I had to de-munge it manually to apply.
> 
> Ugh, does gmail do this?

In my experience, yes.

There's a section in Documentation/SubmittingPatches about using the imap
interface to upload patches into gmail's "Drafts" folder.  SubmittingPatches
then says to "Go to your Gmail account, open the Drafts folder, and find the
patch email, fill in the To: and CC: fields and send away".  I tried that
once and the gmail web interface still introduced new lines.  Either I'm doing
something wrong, or that document should be changed to clarify that the web
interface cannot be used even if the patch is uploaded to the Drafts folder
via imap.

-brandon
