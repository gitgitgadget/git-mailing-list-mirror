From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Todays update (with cogito 0.8)
Date: Sun, 1 May 2005 22:40:25 +0100
Message-ID: <20050501224025.A2079@flint.arm.linux.org.uk>
References: <20050501092743.B7459@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 23:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSM8h-0002G2-6G
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVEAVny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAVne
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:43:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3337 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262738AbVEAVke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:40:34 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DSMAx-0006YZ-9r
	for git@vger.kernel.org; Sun, 01 May 2005 22:40:32 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DSMAs-0000gR-OZ
	for git@vger.kernel.org; Sun, 01 May 2005 22:40:26 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050501092743.B7459@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, May 01, 2005 at 09:27:43AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 01, 2005 at 09:27:43AM +0100, Russell King wrote:
> receiving file list ... done
> client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
> unable to get tags list (non-fatal)
> Tree change: a6ad57fb4b5e9d68553f4440377b99f75588fa88:e8e6993178344eb348f60f05b16d9dc30db3b9cf
> *100644->100644	blob	8da3a306d0c0c070d87048d14a033df02f40a154->48990899db0d9a9506e72fe2fa79570c3b5a306b	Makefile
> *100644->100644	blob	c397e71f938d0f79fbcbf29869fbb1d40cf09306->72b03f201eb946f97c9f419090d683ece6ea5bc1	arch/arm/common/rtctime.c
> *100644->100644	blob	68e15c36e33610d6ed0ccec61d7d7a23ebcd4fa3->3b948e8c27513f7896263a87a99123ad5394b860	arch/arm/mach-integrator/integrator_cp.c
> *100644->100644	blob	20729de2af285d62102691ef20942f7caab184af->1a844ca139e0df85e57cee2a67916aa305b1ffcb	arch/arm/mach-integrator/time.c
> *100644->100644	blob	b1575b8dc1cd3e043f78794c56df9d57e6e96afa->a45aaa115a76664bb81438455b06a6ff890886f7	arch/arm/mach-pxa/generic.c
> *100644->100644	blob	314c7146e9bf0a58c9df75c86065b4ad7598b419->04783ceb050c13d7a475a60bdb916b6eb56ffddf	arch/i386/Makefile
> *100644->100644	blob	774de8e2387193be0570a3fba681fd6dd1936816->f850fb0fb5118be47d976291ee028697fbdeb688	arch/ppc/boot/images/Makefile
> *100644->100644	blob	b0e167db6af9c68f49949d409abc747d3119842f->3c2fa5c284c04ef223c468c2df53f6c7676dc20a	arch/ppc64/kernel/signal32.c
> *100644->100644	blob	8e61be34a1d328c5a948a646504ad65629eaef62->ed867db550a9da16a690a9a122b28d33491ac6f8	drivers/char/s3c2410-rtc.c
> *100644->100644	blob	3e386fd4c5c6e627699ccd04117b712030f0f3f4->321dbe91dc14e270450216cf4cc79562d89ca225	drivers/video/amba-clcd.c
> *100644->100644	blob	4d2404305ab687c2a0eee84b3c5842ba9852965a->95483baab706baa9921eb14757c08da90970fdb5	fs/cifs/CHANGES
> *100644->100644	blob	1e8490ed694878b3bbed1e96ab792791ddf1daed->8cc881694e2911d0a2eff3ca7eb5dd5efc0503d3	fs/cifs/TODO
> *100644->100644	blob	b004fef0a42bac42e8b3490fba19df1ea233762d->741ff0c69f37f44154247020649b4104afff0cda	fs/cifs/cifssmb.c
> *100644->100644	blob	d31c1a71f781ccc7c189e3bff9dc1ee4ee282188->1ab353e235955eee63e43a3a030d0b8b4b719a2b	include/asm-arm/arch-integrator/cm.h
> *100644->100644	blob	aa7e16b2e2255fbcc0f5aef2cf72c241daf2f81b->370dfe77589d2abd9d8a963772fc79072feba5c0	include/asm-arm/rtc.h
> 
> Applying changes...
> Fast-forwarding a6ad57fb4b5e9d68553f4440377b99f75588fa88 -> e8e6993178344eb348f60f05b16d9dc30db3b9cf
> 	on top of a6ad57fb4b5e9d68553f4440377b99f75588fa88...
> The next patch would create the file arch/ia64/sn/include/pci/pcibus_provider_defs.h,
> which already exists!  Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file arch/ia64/sn/include/pci/pcibus_provider_defs.h.rej
> The next patch would create the file arch/ia64/sn/include/pci/pcidev.h,
> which already exists!  Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file arch/ia64/sn/include/pci/pcidev.h.rej

Ok.  Some further information.

I ran cg-diff, which said that these two files were new, and not part
of the kernel tree anymore.  So I removed them.  cg-diff was then happy.

I've just done another update, and they've magically reappeared again.

strings -a .git/index | grep arch/ia64/sn/include/pci/pcidev.h

shows they exist.  After running read-tree $(tree-id) and
update-cache --refresh I think everything's fine again - these files
have certainly gone from the index file.

So it seems that merging in cogito-0.8 isn't working correctly - known
problem or new problem?

-- 
Russell King

